"""
Automatically detect the current monitor configuration using wlr-randr
Arrange the monitors in the specified direction using wlr-randr
Filter monitors by the specified maximum refresh rate
Disables/Enables the interlaced monitor based on the lid state
"""
import argparse
import subprocess

LID_STATE_FILE = '/proc/acpi/button/lid/LID0/state'

def is_monitor_enabled(monitor_name):
    '''Get Enable/Disable status based on the lid state'''

    if monitor_name.startswith('eDP'):
        with open(file=LID_STATE_FILE, mode='r', encoding="utf-8") as f:
            status = f.readlines()
            state = None

            for line in status:
                state = line.split(":")[1].strip()
                break

            return state == 'open'

    return True


def get_monitors():
    '''Get the current monitor configuration using wlr-randr'''

    try:
        result = subprocess.run(['wlr-randr'], stdout=subprocess.PIPE, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error running wlr-randr: {e}")
        return None

    output = result.stdout.decode('utf-8')

    lines = output.strip().split('\n')
    monitors = {}

    current = None

    for line in lines:
        if not line.startswith(' '):
            current = line.split(' ')[0].strip('"')
            monitors[current] = {'modes': []}

        if 'Enabled:' in line:
            monitors[current]['enabled'] = is_monitor_enabled(current)

        if line.startswith('    '):
            props = line.strip().split(' ')

            res = props[0]
            ref = props[2]

            monitors[current]['modes'].append({ 'res': res, 'ref': ref })

    for (_, value) in monitors.items():
        value['modes'] = sorted(value['modes'], key=lambda x: round(float(x['ref'])), reverse=True)

    return monitors


def filter_monitors_by_limit_rate(monitors, rate):
    '''Filter monitors by the specified maximum refresh rate'''

    for monitor in monitors:
        filtered_modes = []

        for mode in monitors[monitor]['modes']:
            if round(float(mode['ref'])) <= int(rate):
                filtered_modes.append(mode)

        monitors[monitor]['modes'] = filtered_modes


    return monitors

def get_pos_and_offset(offset, direction, monitor):
    '''Get the position and offset for a monitor in the specified direction'''

    if direction in ['left', 'right']:
        pos = f"{offset},0"
        offset += int(monitor['modes'][0]['res'].split('x')[0])
    else:  # up or down
        pos = f"0,{offset}"
        offset += int(monitor['modes'][0]['res'].split('x')[1])

    return (pos, offset)

def suspend_system():
    '''Suspend the system and lock the screen using hyprlock'''

    try:
        subprocess.run(
            'systemctl suspend && nohup hyprlock >& /dev/null &',
            shell=True,
            check=True
        )
    except subprocess.CalledProcessError as e:
        print(f"Error suspending system: {e}")

def arrange_monitors(direction, limit_rate):
    '''Arrange monitors in the specified direction using wlr-randr'''

    monitors = get_monitors()
    if monitors is None:
        return

    if direction == 'left':
        monitors = dict(reversed(list(monitors.items())))

    if direction == 'up':
        monitors = dict(reversed(list(monitors.items())))

    is_only_internal = len(monitors) == 1 and list(monitors.keys())[0].startswith('eDP')

    if limit_rate is not None:
        monitors = filter_monitors_by_limit_rate(monitors, limit_rate)

    offset = 0

    for monitor in monitors:
        if monitors[monitor]['enabled']:
            res = monitors[monitor]['modes'][0]['res']
            ref = monitors[monitor]['modes'][0]['ref']

            mode = f"{res}@{ref}"

            (pos, offset) = get_pos_and_offset(offset, direction, monitors[monitor])

            try:
                print(f"Setting monitor {monitor} to mode {mode} at position {pos}")

                subprocess.run(['wlr-randr', '--output', monitor, '--on'], check=True)
                subprocess.run(
                    [
                        'wlr-randr',
                        '--output',monitor,
                        '--mode', mode,
                        '--pos', pos,
                        '--scale', '1'
                    ],
                    check=True
                )
            except subprocess.CalledProcessError as e:
                print(f"Error arranging monitor {monitor}: {e}")
        else:
            if is_only_internal:
                suspend_system()
            else:
                try:
                    subprocess.run(['wlr-randr', '--output', monitor, '--off'], check=True)
                    subprocess.run(['hyprctl keyword monitor', f'"{monitor}, disable"'], check=True)
                except subprocess.CalledProcessError as e:
                    print(f"Error arranging monitor {monitor}: {e}")


def run():
    '''Run the main function'''

    parser = argparse.ArgumentParser(description='Arrange monitors in a specified direction.')
    parser.add_argument(
        '--direction',
        choices=['left', 'right', 'up', 'down'],
        required=True,
        help='The direction to arrange the monitors.'
    )
    parser.add_argument(
        '--limit-rate',
        choices=['360', '300', '240', '165', '120', '60'],
        required=False,
        help='The maximum refresh rate to use.'
    )
    args = parser.parse_args()

    arrange_monitors(args.direction, args.limit_rate)


if __name__ == "__main__":
    run()

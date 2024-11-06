# check_gem

`check_gem` is a nagios plugin to check if gem updates are available.
gem outdated returns a list of gems for which updates are available.

## Install

copy the `check_gem` plugin into your plugin directory, usually `/usr/lib/nagios/plugins/`:
```bash
sudo cp check_gem /usr/lib/nagios/plugins/
```

Make sure the script is executable:
```bash
sudo chmod +x /usr/lib/nagios/plugins/check_gem
```

## Usage

Run the script with the following parameters:

```bash
/usr/lib/nagios/plugins/check_gem -w 5 -c 20
```

### Options

- `-w`, `--warning <number>`  Minimum number of gem packages available for upgrade to return `WARNING` status. Default: 1
- `-c`, `--critical <number>` Minimum number of gem packages available for upgrade to return `CRITICAL` status. Default: 10
- `-h`, `--help`              Display this help message.

## Example

```bash
/usr/lib/nagios/plugins/check_gem -w 5 -c 15
CRITICAL - 16 gem(s) need updates
```

### Test

Run test with:
```bash
docker run -it -v "$PWD:/code" bats/bats:latest /code/test
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

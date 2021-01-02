# Sms express

Send sms messages with a device and read contact list from a terminal. Powered by [Node Commander](https://github.com/synw/nodecommander)

## Usage

Generate a key:

```
dart bin/main.dart
HZo4dC_zLjRXvikcQyfCsC8za4_LKIOit6r-lUsbmeM=
```

Run the Flutter app on a device: `flutter run --dart-define="KEY=HZo4dC_zLjRXvikcQyfCsC8za4_LKIOit6r-lUsbmeM="`

Run the cli: `dart bin/main.dart HZo4dC_zLjRXvikcQyfCsC8za4_LKIOit6r-lUsbmeM=` and
connect to the device:

```
? smsexpress » /d
📢 Soldier smsexpress connected at 192.168.1.6:8084
Found soldier smsexpress at 192.168.1.6:8084
? command » /u
✔ command ‥ /u
Using soldier smsexpress
? smsexpress »
```

## Commands

**contacts**: get a list of contacts in json

**names**: get a list of names in the contact book

**numbers**: get a list of names with phone numbers in the contact book

**sms**: send a sms to a contact:

```
? rcontact » sms Name_of_contact This is the message text
```

Note: use _ to replace spaces in the contact names


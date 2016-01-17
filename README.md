# docker-samba

This is a [docker](https://www.docker.io) container that runs samba

The current latest samba in debian and ubuntu repos is not recent enough to support some new (really important) features for use with new versions of Mac OSX. To that end, I made my own.  It's a bit edge-case-y and really only intended to be convenient for my environment, but take a look at the usage below to see if it's helpful to you!

You'll notice a few things:
  * No attempt is made to auto-share or manage your smb.conf file
  * You have full control to pass in users that will end up in `/etc/passwd` in the container (as well as their uid) to best support fine-grain access control with samba and existing file permissions.

## Usage

  * expose ports: `137`,`138`,`139`,`445`
  * link an `smb.conf` file to `/conf/smb.conf` 
  * link your current samba private dir (where the user/pw db lies) to `/private`
  * link up any shares (matching their location to the `smb.conf` file above)
  * pass a `USER_LIST` env variable in format: `user1:uid1 user2:uid2` 

## License

Licensed under the Apache Version 2.0 license. See `LICENSE` file for full text.
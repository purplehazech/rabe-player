
class player {

 # needed in /etc/inittab
 #c7:2345:respawn:/sbin/mingetty --autologin player tty8

 package { "net-dialup/mingetty":
   ensure => installed,
 }

/** just plain wrong
 file { "/var/lib/player/.config/autostart/20osc2midi":
   ensure  => file,
   content => template('/usr/local/share/faderstart/faderstart-osc2midi-ard2.pd'),
 }
**/

 file { "/var/lib/player/.config/autostart/40mixxx":
   ensure  => '/usr/bin/mixxx',
 }

}

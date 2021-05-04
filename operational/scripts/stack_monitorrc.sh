sessionname stack
#hardstatus alwayslastline '%{= .} %-Lw%{= .}%> %n%f %t*%{= .}%+Lw%< %-=%{g}(%{d}%H/%l%{g})'
caption always "%{= kw}%-w%{= kG}%{+b}[%n %t]%{-b}%{= kw}%+w %=%d %M %0c %{g}%H%{-}"
termcapinfo rxvt 'hs:ts=\E]2;:fs=\007:ds=\E]2;screen\007'
setenv PROMPT_COMMAND /bin/true
screen -t shell bash
screen -t keystone bash
"tuff "tail -f /var/log/apache2/keystone.log
screen -t keystone-access bash
"tuff "tail -f /var/log/apache2/keystone_access.log
screen -t nova-compute bash
"tuff "tail -f /var/log/nova/nova-compute.log
screen -t nova-conductor bash
"tuff "tail -f /var/log/nova/nova-conductor.log
screen -t nova-scheduler bash
"tuff "tail -f /var/log/nova/nova-scheduler.log
screen -t cinder-volume bash
"tuff "tail -f /var/log/cinder/cinder-volume.log
screen -t cinder-scheduler bash
"tuff "tail -f /var/log/cinder/cinder-scheduler.log

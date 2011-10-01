
install: install_ALL

install_ALL: install_puppet

install_puppet:
	cd puppet/modules && \
	find ./ -type d -exec mkdir -p /usr/share/puppet/modules/{} \; && \
	find ./ -type f -exec cp    {} /usr/share/puppet/modules/{} \;

# my-batched
## Make sure the user who the dispatcher is running on must has a valid ssh client setup(that is, there is
## a .ssh directory under his HOME with pub/priv key and a known_hosts file with the host keys to run jobs),
## or the dispatcher will fail to run remote job via ssh with a strange error message which just says FILE in the stderr.

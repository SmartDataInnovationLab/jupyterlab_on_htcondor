# Work in progress

# jupyterlab_on_htcondor

WIP. We are trying to run jupyterlab via condor, such that the use can connect to it from it's client

## use case

User runs a script, on his local machine, that 

1. connects to sdil
1. stops old instances on htcondor
1. starts jupyterlab on htcondor
1. creates an ssh-tunnel to jupyterlab
1. starts a local browser, that is connected to jupyterlab

## benefit

* This will give the user full controll over the her working environment. E.g. it is currently not possible to run jupyterlab on sdil. 
* The startup-procedure is simpler than the current jupyter-hub workflow, which requires 2 separate logins. With this workflow the user only needs to login once

bonus: 

The script can include a part, that kills the job, when there is no user connected, and the is also no kernel running for some time. This would solve the issue of zombie jobs reserving CPUs


## steps to create this / unsolved issues

### ssh tunnel

open a tunnel from the client to the condor job. 

condor_ssh_to_job + "ssh -D/L" seems to be promising. In the very least we can look at the sourcecode of condor_ssh_to_job and implement our own version, that does port forwarding. 

http://research.cs.wisc.edu/htcondor/manual/current/condor_ssh_to_job.html

### running jupyterlab

you need to install and run jupyterlab. This can probably be done with anaconda.

### automate and simplify it

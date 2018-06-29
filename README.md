# Work in progress

# jupyterlab_on_htcondor

WIP. We are trying to run jupyterlab via condor, such that the use can connect to it from it's client

## quick start

**replace "ugfam" with your sdil account!**

prepare container

		ssh ugfam@login-l.sdil.kit.edu
		cd dev
		git clone git@github.com:SmartDataInnovationLab/jupyterlab_on_htcondor.git
		setup-anaconda
		# note: the next step take ~30 minutes
		conda create --name=my_env --clone=anaconda-py35 --copy
		conda install --name my_env -c conda-forge jupyterlab

start container

    ssh -L 8888:127.0.0.1:8888 ugfam@login-l.sdil.kit.edu "cd dev/jupyterlab_on_condor && ID=\$(token=abcd condor_submit run.sub | grep -Eo '[0-9]{4,10}\.') && condor_ssh_to_job -auto-retry -ssh \"ssh -L 8888:127.0.0.1:8888 -nNf \" \$ID"

At first you need to enter your sdil-credentials. Then the command runs forever and won't tell you if it failed. Also sometimes the container just doesn't start. When you can't connect after 10 seconds, open another terminal and look at `condor_q -analyze` and maybe do a `condor_rm $ID` and then try again

connect to container:

		firefox "localhost:8888/?token=abcd"

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

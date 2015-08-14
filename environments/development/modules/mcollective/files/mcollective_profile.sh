function mco_df() { 
    if [ $# == 2 ]
    then
        mco rpc --np -T "$1" -S "$2" -a checkdiskspace --action check;
    elif [ $# == 1 ]
    then
        mco rpc --np -T "$1" -a checkdiskspace --action check ; 
    else
        echo "Need at least one arg - region [ us,useast, or all ]"
        echo "optional 2nd args, the facter fact to filter on"
        echo "ex. mco_df useast environment=dev"
        return
    fi
}
function mco_mail_check() { 
    if [ $# == 2 ]
    then
        mco rpc --np -T "$1" -S "$2" -a checkmailqueue --action check ;
    elif [ $# == 1 ]
    then
        mco rpc --np -T "$1" -a checkmailqueue --action check ; 
    else
        echo "Need at least one arg - region [ us,useast, or all ]"
        echo "optional 2nd arg, the facter fact to filter on"
        echo "ex. mco_mail_check useast environment=dev"
        return
    fi
}
function mco_mail_flush() { 
    if [ $# == 2 ]
    then
        mco rpc --np -T "$1" -S "$2" -a checkmailqueue --action flush ;
    elif [ $# == 1 ]
    then
        mco rpc --np -T "$1" -a checkmailqueue --action flush ; 
    else
        echo "Need at least one arg - region [ us,useast, or all ]"
        echo "optional 2nd arg, the facter fact to filter on"
        echo "ex. mco_mail_flush useast environment=dev"
        return
    fi
}
function mco_mail_purge() { 
    if [ $# == 2 ]
    then
        mco rpc --np -T "$1" -S "$2" -a checkmailqueue --action purge ;
    elif [ $# == 1 ]
    then
        mco rpc --np -T "$1" -a checkmailqueue --action purge ; 
    else
        echo "Need at least one arg - region [ us,useast, or all ]"
        echo "optional 2nd arg, the facter fact to filter on"
        echo "ex. mco_mail_purge useast environment=dev"
        return
    fi
}
function mco_puppet_kick() { 
    if [ $# == 2 ]
    then
        mco rpc --np -T "$1" -S "$2" -a puppet --action runonce ; 
    elif [ $# == 1 ]
    then
        mco rpc --np -T "$1" -a puppet --action runonce ; 
    else
        echo "Need at least one arg - region [ us,useast, or all ]"
        echo "optional 2nd arg, the facter fact to filter on"
        echo "ex. mco_puppet_kick useast environment=dev"
        return
    fi
}
function mco_puppet_summary() { 
    if [ $# == 2 ]
    then
        mco rpc --np -T "$1" -S "$2" -a puppet --action last_run_summary ;
    elif [ $# == 1 ]
    then
	mco rpc --np -T "$1" -a puppet --action last_run_summary ; 
    else
        echo "Need at least one arg - region [ us,useast, or all ]"
        echo "optional 2nd arg, facter fact to filter on"
        echo "ex. mco_puppet_summary useast environment=dev"
        return
    fi
}
function mco_service() { 
    if [ $# == 4 ]
    then
	mco rpc service "$2" service="$1" -T "$3" -S "$4" ; 
    elif [ $# == 4 ]
    then
	mco rpc service "$2" service="$1" -T "$3" ; 
    else
        echo "Need at least three args - servicename, action, region [ us,useast, or all ]"
        echo "optional fourth arg, the facter fact to filter on"
        echo "ex. mco_service ntpd restart useast environment=dev"
        return
    fi
}

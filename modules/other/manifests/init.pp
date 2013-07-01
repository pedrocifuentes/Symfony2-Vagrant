class other 
{
    package 
    { 
        "curl":
            ensure  => present,
            require => Exec['apt-get update']
    }
    
    package 
    { 
        "vim":
            ensure  => present,
            require => Exec['apt-get update']
    }
}

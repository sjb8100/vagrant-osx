GH_TOKEN=$1
UNLOCK=$2

echo "Setting up boxen using GH token $GH_TOKEN..."

# Allow testing dev modules
mkdir -p ~/src
if [ ! -h ~/src/boxen ]; then
  ln -s /vagrant ~/src/boxen
fi

# Unlock boxen (necessary if it has been killed)
if [ $UNLOCK ]; then
  ruby -e 'File.new("/opt/boxen/repo/script/boxen").flock File::LOCK_UN'
fi

# Run boxen
cd /opt/boxen/repo
./script/boxen --no-fde --debug --token=$GH_TOKEN

# Set up boxen environment variables
echo 'if [ -f /opt/boxen/env.sh ]; then source /opt/boxen/env.sh; fi' > ~/.bash_profile
source ~/.bash_profile

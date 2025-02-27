#!/usr/bin/with-contenv bashio
pushd /opt/custom_broker >/dev/null
source /opt/utils/bashutils.sh

DEBUG_MODE=$(get_option 'debug_mode' 'false')

# Start flask
bashio::log.info "Starting flask..."
if [[ $DEBUG_MODE == "true" ]]; then
  bashio::log.info "Setting flask debug flags"
  export ENABLE_DEBUG=True
  export DEBUG_PORT=$(get_option 'debug_port' '10001')
  exec python3 -m debugpy --listen 0.0.0.0:$DEBUG_PORT ./http_api.py
else
  bashio::log.info "Setting flask production flags"
  export ENABLE_DEBUG=False
  exec python3 ./http_api.py
fi

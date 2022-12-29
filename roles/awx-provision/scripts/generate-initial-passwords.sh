#!/usr/bin/env bash
# Based on a bash script for generating strong passwords for the Jitsi role in this ansible project:
# https://github.com/spantaleev/matrix-docker-ansible-deploy

generatePassword() {
    openssl rand -hex 16
}

usage() {
  echo "Usage: $0 matrix_domain awx_element_subdomain client_email output_file"
}
DOMAIN="$1"; shift
if [ "" = "$DOMAIN" ]; then usage 2>&1; exit 1; fi
ELEMENT_SUBDOMAIN="$1"; shift
if [ "" = "$ELEMENT_SUBDOMAIN" ]; then usage 2>&1; exit 1; fi
CLIENT_EMAIL="$1"; shift
if [ "" = "$CLIENT_EMAIL" ]; then usage 2>&1; exit 1; fi
VARFILE="$1"; shift
if [ "" = "$VARFILE" ]; then usage 2>&1; exit 1; fi

cat <<VAREND > "$VARFILE"
# AWX Settings Start
matrix_awx_enabled: true
awx_janitor_user_password: $(generatePassword)
awx_janitor_user_created: false
awx_dimension_user_password: $(generatePassword)
awx_dimension_user_created: false
awx_mjolnir_user_password: $(generatePassword)
awx_mjolnir_user_created: false
awx_backup_enabled: false
# AWX Settings End
# Basic Settings Start
matrix_domain: $DOMAIN
matrix_coturn_turn_static_auth_secret: $(generatePassword)
matrix_homeserver_generic_secret_key: $(generatePassword)
# Basic Settings End
# Element Settings Start
matrix_client_element_enabled: true
matrix_server_fqn_element: $ELEMENT_SUBDOMAIN.$DOMAIN
matrix_client_element_jitsi_preferredDomain: jitsi.$DOMAIN
# Element Settings End
# Element Extension Start
matrix_client_element_configuration_extension_json: |
  "disable_3pid_login": true
# Element Extension End
# Email Settings Start
matrix_mailer_sender_address: verify@mail.example.org
matrix_mailer_relay_use: false
matrix_mailer_relay_host_name: smtp.mailgun.org
matrix_mailer_relay_host_port: 587
matrix_mailer_relay_auth: true
matrix_mailer_relay_auth_username: user@mail.example.org
matrix_mailer_relay_auth_password: $(generatePassword) 
# Email Settings End
# ma1sd Settings Start
matrix_ma1sd_enabled: true 
# ma1sd Settings End
# ma1sd Extension Start
# ma1sd Extension End
# Mjolnir Settings Start
matrix_bot_mjolnir_enabled: false
# Mjolnir Settings End
# Mjolnir Extension Start
matrix_bot_mjolnir_configuration_extension_yaml: |
  "homeserverUrl": "http://matrix-synapse:8008"
  "rawHomeserverUrl": "http://matrix-synapse:8008"
# Mjolnir Extension End
# Jitsi Settings Start
matrix_jitsi_jicofo_component_secret: $(generatePassword)
matrix_jitsi_jicofo_auth_password: $(generatePassword)
matrix_jitsi_jvb_auth_password: $(generatePassword)
matrix_jitsi_jibri_recorder_password: $(generatePassword)
matrix_jitsi_jibri_xmpp_password: $(generatePassword)
# Jitsi Settings End
# Synapse Settings Start
matrix_synapse_auto_join_rooms: []
matrix_synapse_container_metrics_api_host_bind_port: 9000
matrix_synapse_metrics_enabled: true
matrix_synapse_metrics_port: 9100
matrix_synapse_federation_enabled: false
matrix_synapse_allow_public_rooms_over_federation: true
matrix_synapse_enable_registration: false
matrix_synapse_caches_global_factor: 4.0
matrix_synapse_url_preview_enabled: true
matrix_synapse_registration_shared_secret: $(generatePassword)
matrix_synapse_allow_guest_access: false
matrix_synapse_workers_enabled: false
matrix_synapse_workers_preset: little-federation-helper
matrix_synapse_rc_login:
    address:
        per_second: 0.17
        burst_count: 3
    account:
        per_second: 0.17
        burst_count: 3
    failed_attempts:
        per_second: 0.17
        burst_count: 3
# Synapse Settings End
# Synapse Extension Start
matrix_synapse_ext_password_provider_rest_auth_enabled: false
matrix_synapse_ext_password_provider_rest_auth_endpoint: "http://matrix-corporal:41080/_matrix/corporal"
matrix_synapse_configuration_extension_yaml: |
  autocreate_auto_join_rooms: true
  mau_stats_only: true
  admin_contact: 'mailto:$CLIENT_EMAIL'
  limit_remote_rooms:
    enabled: true
    complexity: 1.0
  limit_usage_by_mau: false
  url_preview_accept_language:
    - en
# Synapse Extension End
# PostgreSQL Settings Start
matrix_postgres_connection_password: $(generatePassword)
matrix_synapse_connection_password: $(generatePassword)
# PostgreSQL Settings End
# Base Domain Settings Start
# Base Domain Settings End
# Synapse Admin Settings Start
matrix_synapse_admin_enabled: false
# Synapse Admin Settings End
# Shared Secret Auth Settings Start
matrix_synapse_ext_password_provider_shared_secret_auth_enabled: false
matrix_synapse_ext_password_provider_shared_secret_auth_shared_secret: $(generatePassword)
# Shared Secret Auth Settings End
# Corporal Settings Start
matrix_corporal_enabled: false
matrix_corporal_http_api_enabled: false
matrix_corporal_corporal_user_id_local_part: "matrix-corporal"
# Corporal Settings End
# Corporal Policy Provider Settings Start
# Corporal Policy Provider Settings End
# Dimension Settings Start
matrix_dimension_enabled: false
# Dimension Settings End
# Bridge Discord AppService Start
# Bridge Discord AppService End
# Extra Settings Start
matrix_vars_yml_snapshotting_enabled: false
# Extra Settings End
# Custom Settings Start
awx_federation_whitelist_raw: []
awx_url_preview_accept_language_default: ['en']
# Custom Settings End
VAREND

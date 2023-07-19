{%macro utc_to_est(cloumn_name) -%}
convert_timezone('UTC', 'America/New_York', {{ cloumn_name }})
{%- endmacro %}
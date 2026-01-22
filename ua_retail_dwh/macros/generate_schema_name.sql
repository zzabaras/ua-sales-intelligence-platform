{% macro generate_schema_name(custom_schema_name, node) -%}

    {# Если в модели или YML НЕ указана схема, используем дефолтную из profiles.yml #}
    {%- if custom_schema_name is none -%}

        {{ target.schema }}

    {# Если схема указана (silver или gold), используем ТОЛЬКО её #}
    {%- else -%}

        {{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}
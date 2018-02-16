cat $file | tsload \
  --empty_target \
  --field_separator "," \
  --target_database "$database" \
  --target_table "$table"  \
  --source_data_format csv \
  --null_value "" \
  --max_ignored_rows 0 \
  --date_format "%Y%m" \
  --bad_records_file $table.bad
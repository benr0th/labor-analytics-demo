DELETE FROM labor_data
WHERE 
  ({{ id }}::text IS NOT NULL AND hunkware_id = {{ id }}::text)
  OR
  ({{ id }}::text IS NULL AND date = {{ date }} AND shift_team = {{ shift_team }})
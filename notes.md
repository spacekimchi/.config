## Data tables
- User
  - id
  - username
  - email
  - spots

- Spot
  - id
  - points: [top_left, bottom_right]
  - user_id

## PSQL commands
This will start psql and connect to database
`psql -U {username /* usually postgres */} -d {database name}`
Otherwise use `\c {database name}` to connect to a database

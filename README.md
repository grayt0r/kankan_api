# Kankan REST API

## Boards

Example URL: http://localhost:3000/api/v1/boards.json

<table>
  <tr>
    <th style="text-align:left;">Resource</th>
    <th style="text-align:left;">Description</th>
  </tr>
  <tr>
    <td>GET boards.json</td>
    <td>Returns all boards created by the current user.</td>
  </tr>
  <tr>
    <td>POST boards.json</td>
    <td>Creates a new board.</td>
  </tr>
  <tr>
    <td>GET boards/:id.json</td>
    <td>Returns details of a specific board.</td>
  </tr>
  <tr>
    <td>PUT boards/:id.json</td>
    <td>Updates an existing board.</td>
  </tr>
  <tr>
    <td>DELETE boards/:id.json</td>
    <td>Deletes a board.</td>
  </tr>
</table>
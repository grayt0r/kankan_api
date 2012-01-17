# Kankan REST API

All API calls require an auth_token, which is used to authenticate the user.

Only the board owner has access to the lanes and cards contained within a board.


## Boards

Example URL: http://localhost:3000/api/v1/boards.json

<table>
  <tr>
    <th style="text-align:left;">Resource</th>
    <th style="text-align:left;">Description</th>
    <th style="text-align:left;">Params</th>
  </tr>
  <tr>
    <td>GET boards.json</td>
    <td>Returns all boards created by the current user.</td>
    <td></td>
  </tr>
  <tr>
    <td>POST boards.json</td>
    <td>Creates a new board.</td>
    <td></td>
  </tr>
  <tr>
    <td>GET boards/:id.json</td>
    <td>Returns details of a specific board.</td>
    <td></td>
  </tr>
  <tr>
    <td>PUT boards/:id.json</td>
    <td>Updates a specific board.</td>
    <td></td>
  </tr>
  <tr>
    <td>DELETE boards/:id.json</td>
    <td>Deletes a specific board.</td>
    <td></td>
  </tr>
</table>


## Lanes

Example URL: http://localhost:3000/api/v1/lanes.json

<table>
  <tr>
    <th style="text-align:left;">Resource</th>
    <th style="text-align:left;">Description</th>
    <th style="text-align:left;">Params</th>
  </tr>
  <tr>
    <td>GET lanes.json</td>
    <td>Returns all lanes for the specified board.</td>
    <td>board_id (required)</td>
  </tr>
  <tr>
    <td>POST lanes.json</td>
    <td>Creates a new lane for the specified board.</td>
    <td>board_id (required)</td>
  </tr>
  <tr>
    <td>GET lanes/:id.json</td>
    <td>Returns details of a specific lane.</td>
    <td></td>
  </tr>
  <tr>
    <td>PUT lanes/:id.json</td>
    <td>Updates a specific lane.</td>
    <td></td>
  </tr>
  <tr>
    <td>DELETE lanes/:id.json</td>
    <td>Deletes a specific lane.</td>
    <td></td>
  </tr>
</table>


## Cards

Example URL: http://localhost:3000/api/v1/cards.json

<table>
  <tr>
    <th style="text-align:left;">Resource</th>
    <th style="text-align:left;">Description</th>
    <th style="text-align:left;">Params</th>
  </tr>
  <tr>
    <td>GET cards.json</td>
    <td>Returns all cards for the specified lane.</td>
    <td>lane_id (required)</td>
  </tr>
  <tr>
    <td>POST cards.json</td>
    <td>Creates a new card for the specified lane.</td>
    <td>lane_id (required)</td>
  </tr>
  <tr>
    <td>GET cards/:id.json</td>
    <td>Returns details of a specific card.</td>
    <td></td>
  </tr>
  <tr>
    <td>PUT cards/:id.json</td>
    <td>Updates a specific card.</td>
    <td></td>
  </tr>
  <tr>
    <td>DELETE cards/:id.json</td>
    <td>Deletes a specific card.</td>
    <td></td>
  </tr>
</table>
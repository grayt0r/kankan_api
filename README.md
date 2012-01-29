# Kankan JSON REST API

Create, retrieve, update and delete all the elements required for a [Kanban board](http://en.wikipedia.org/wiki/Personal_Kanban) visualisation.

All API calls require an auth_token, apart from the call to obtain an auth_token. Currently only the board owner has access to the lanes and cards contained within a board.

Please note that this project is in the very early days of development. There is likely to be bugs and a lot of the functionality is yet to be implemented - see the TODOs in the [kankan_backbone](https://github.com/grayt0r/kankan_backbone) project for more information.


## Installation

* git clone git://github.com/grayt0r/kankan_api.git
* cd kankan_api
* bundle install
* rake db:migrate (if you want a test board to play with, also run rake db:seed)
* rails s
* Open http://localhost:3000 in your browser and check you see the welcome message


## Tokens

Example URL: http://localhost:3000/api/v1/tokens.json

<table>
  <tr>
    <th style="text-align:left;">Resource</th>
    <th style="text-align:left;">Description</th>
    <th style="text-align:left;">Params</th>
  </tr>
  <tr>
    <td>POST tokens.json</td>
    <td>Authenticates a user, returning an auth_token if successful.</td>
    <td>email, password</td>
  </tr>
</table>


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
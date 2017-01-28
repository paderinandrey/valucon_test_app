$LOAD_PATH.unshift 'lib'
require 'trello_board'

board = TrelloBoard.new('58873f918632b3ac6912179c')
board.create_card!(title: 'my title', description: 'bla bla', list_id: '58873f9a23f8f6ac9310119b')

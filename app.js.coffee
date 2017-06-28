ReactDOM = require('react-dom')
if document.getElementById('fayesection')
  FayeInit = require('./components/faye_init.js.coffee')
  ReactDOM.render(<FayeInit />, document.getElementById('fayesection'))
if document.getElementById('landlordmenu') 
  LandlordMenu = require('./components/menus/landlord_menu.js.coffee')
  ReactDOM.render(<LandlordMenu />, document.getElementById('landlordmenu'))
if document.getElementById('landlordpage')
  LandlordPageController = require('./components/page_controllers/landlord_page_controller.js.coffee')
  ReactDOM.render(<LandlordPageController />, document.getElementById('landlordpage'))
if document.getElementById('mainfeed') 
  FeedSection = require('./components/activities/feed_section.js.coffee')
  ReactDOM.render(<FeedSection />, document.getElementById('mainfeed'))
if document.getElementById('peopleapartment') 
  PeopleActionsCard = require('./components/people/people_actions.js.coffee')
  ReactDOM.render(<PeopleActionsCard />, document.getElementById('peopleapartment'))
if document.getElementById('newaction') 
  NewActionsSection = require('./components/actions/new_actions_section.js.coffee')
  ReactDOM.render(<NewActionsSection />, document.getElementById('newaction'))
if document.getElementById('recenttasks') 
  RecentTasksSection = require('./components/activities/recent_tasks_section.js.coffee')
  ReactDOM.render(<RecentTasksSection />, document.getElementById('recenttasks'))
if document.getElementById('peoplesection') 
  PeopleSection = require('./components/people/people_section.js.coffee')
  ReactDOM.render(<PeopleSection />, document.getElementById('peoplesection'))
if document.getElementById('portfoliosection') 
  PortfolioSection = require('./components/portfolios/portfolio_section.js.coffee')
  ReactDOM.render(<PortfolioSection />, document.getElementById('portfoliosection'))
if document.getElementById('addbuilding') 
  NewBuildingSection = require('./components/actions/new_building_section.js.coffee')
  ReactDOM.render(<NewBuildingSection />, document.getElementById('addbuilding'))
if document.getElementById('addrequests') 
  NewRequestSection = require('./components/requests/new_request_section.js.coffee')
  ReactDOM.render(<NewRequestSection />, document.getElementById('addrequests'))
if document.getElementById('requestssection') 
  RequestSection = require('./components/requests/requests_section.js.coffee')
  ReactDOM.render(<RequestSection />, document.getElementById('requestssection'))
if document.getElementById('contact') 
  ContactSection = require('./components/contacts/contact_section.js.coffee')
  ReactDOM.render(<ContactSection />, document.getElementById('contact'))
if document.getElementById('landlordpayments') 
  LandlordPaymentsSection = require('./components/payments/landlord_payments_section.js.coffee')
  ReactDOM.render(<LandlordPaymentsSection />, document.getElementById('landlordpayments'))
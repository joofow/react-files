BuildingStore = require('../../stores/building_store.js.coffee')
PaymentsStore = require('../../stores/payments_store.js.coffee')
PostStore = require('../../stores/posts_store.js.coffee')
ProjectStore = require('../../stores/project_store.js.coffee')
PropertiesPage = require('../pages/properties_page.js.coffee')
PaymentsPage = require('../pages/payments_page.js.coffee')
PostsPage = require('../pages/posts_page.js.coffee')
ProjectsPage = require('../pages/projects_page.js.coffee')
NoticesPage = require('../pages/notices_page.js.coffee')
BuildingViewActions = require('../../actions/buildings_view_actions.js.coffee')
PeopleStore =  require('../../stores/people_store.js.coffee')
PeopleActionCreators = require('../../actions/people_view_actions.js.coffee')
NewPropertyController = require('../buildings/new_property_controller.js.coffee')
NewPostController = require('../posts/new_posts_controller.js.coffee')
NewProjectController = require('../maintenance/new_project_controller.js.coffee')
ApartmentStore = require('../../stores/apartment_store.js.coffee')
MessagesViewActions = require('../../actions/messages_view_actions.js.coffee')

getCurrentPage = ->
	current_page: BuildingStore.getCurrentPage()

getAllBuildings = ->
	apartments: ApartmentStore.getApartments()
	buildings: BuildingStore.getAllBuildings()
	building: BuildingStore.getActiveBuilding()
	directory: BuildingStore.getDirectory()
	deposits: PaymentsStore.getDeposit()
	payments: PaymentsStore.getPayments()
	outstanding: PaymentsStore.getOutstanding()
	received: PaymentsStore.getReceived()
	new_projects: ProjectStore.getNewProjects()
	waiting_projects: ProjectStore.getWaitingProjects()
	scheduled_projects: ProjectStore.getScheduledProjects()
	completed_projects: ProjectStore.getCompletedProjects()
	closed_projects: ProjectStore.getClosedProjects()
	posts: PostStore.getPosts()
	initial: BuildingStore.getInitialStatus()
	people: PeopleStore.getAll()
	filtered_buildings: BuildingStore.getAllBuildings()
	archive: PostStore.getArchive()
	filtered: ''
	me: PeopleStore.getMe()
	show_new_project: false

LandlordPageController = React.createClass
	displayName: 'LandlordPage'

	getInitialState: ->
		$.extend getAllBuildings(), getCurrentPage(), { show_action: false, show_new_post: false, show_new_project: false }

	componentWillUnmount: ->
		BuildingStore.removeChangeListener 'change', @_onChange
		BuildingStore.removeChangeListener 'new_page', @_onChange
		PaymentsStore.removeChangeListener 'change', @_onChange, show_new_project
		PostStore.removeChangeListener 'change', @_onChange
		ProjectStore.removeChangeListener 'change', @_onChange
		ApartmentStore.removeChangeListener @_onChange

	componentDidMount: ->
		BuildingStore.addChangeListener 'new_page', @_showPage
		BuildingStore.addChangeListener 'change', @_onChange
		BuildingStore.addChangeListener 'added', @_add_new_building
		PaymentsStore.addChangeListener 'change', @_onChange
		PostStore.addChangeListener 'change', @_onChange
		ProjectStore.addChangeListener 'change', @_onChange
		ApartmentStore.addChangeListener @_onChange
		PeopleActionCreators.getPeople()
		BuildingViewActions.getBuildings()
		BuildingViewActions.getApartments()
		MessagesViewActions.getAllMessages()
		BuildingViewActions.getDirectory()
		BuildingViewActions.getPayments()
		BuildingViewActions.getPosts()
		BuildingViewActions.getProjects()


	_showPage: ->
		@setState getCurrentPage()

	_onChange: ->
		@setState getAllBuildings()

	_add_new_building:->
		@setState
			show_action: !@state.show_action

	_add_new_post: ->
		@setState
			show_new_post: !@state.show_new_post

	_add_new_project: ->
		@setState
			show_new_project: !@state.show_new_project

	_filter_buildings: (exp) ->
		re = new RegExp(exp,"g");
		temp_state = @state.buildings.filter (b) ->
			(b.address_line_1 && b.address_line_1.match re) || (b.address_line_2 && b.address_line_2.match re) || (b.city_name && b.city_name.match re) || (b.zipcode && b.zipcode.toString().match re)
		@setState
			filtered_buildings: temp_state
			filtered: exp

	render: ->
		visible = switch @state.current_page
		 when 'properties' then {prop: true, pay: false, speak: false, main: false, notice: false }
		 when 'payment' then {prop: false, pay: true, speak: false, main: false, notice: false }
		 when 'speaker' then {prop: false, pay: false, speak: true, main: false, notice: false }
		 when 'maintain' then {prop: false, pay: false, speak: false, main: true, notice: false }
		 when 'notice' then {prop: false, pay: false, speak: false, main: false, notice: true }
		<section>
			<NewPropertyController open={@state.show_action} close_new_property={@_add_new_building} />
			<NewPostController open={@state.show_new_post} close_new_post={@_add_new_post} people={@state.people} buildings={@state.buildings}/>
			<NewProjectController open={@state.show_new_project} close_new_project={@_add_new_project} />
			<PropertiesPage key={'property_' +	Math.floor(Date.now() / 1000)} data={@state} people={@state.people} visible={ if visible['prop'] then '' else 'hide' } show_new_property={@_add_new_building} search={@_filter_buildings}/>
			<PostsPage key={'comms_' +	Math.floor(Date.now() / 1000)} people={@state.people} data={@state} visible={ if visible['speak'] then '' else 'hide'} show_new_post={@_add_new_post}/>
			<ProjectsPage key={'main_' +	Math.floor(Date.now() / 1000)} data_new={@state.new_projects} data_waiting={@state.waiting_projects} data_scheduled={@state.scheduled_projects} data_completed={@state.completed_projects} data_closed={@state.closed_projects} people={@state.people} apartments={@state.apartments} buildings={@state.buildings} directory={@state.directory} visible={ if visible['main'] then '' else 'hide'} show_new_project={@_add_new_project}/>
 		<NoticesPage key={'notices_' +	Math.floor(Date.now() / 1000)} data={@state} people={@state.people} visible={ if visible['notice'] then '' else 'hide'}/>
 	</section>

module.exports = LandlordPageController
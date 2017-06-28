ConversationsServerActions = require('../actions/conversations_server_actions.js.coffee')
MessagesServerActions =  require('../actions/messages_server_actions.js.coffee')
PeopleServerActions = require('../actions/people_server_actions.js.coffee')
TasksServerActions = require('../actions/tasks_server_actions.js.coffee')
RemindersServerActions = require('../actions/reminders_server_actions.js.coffee')
PaymentsServerActions = require('../actions/payments_server_actions.js.coffee')
ApartmentServerActions = require('../actions/apartment_server_actions.js.coffee')
BuildingsServerActions = require('../actions/buildings_server_actions.js.coffee')
RequestsServerActions = require('../actions/requests_server_actions.js.coffee')
PostsServerActions = require('../actions/posts_server_actions.js.coffee')
ProjectsServerActions = require('../actions/projects_server_actions.js.coffee')
AddressesServerActions = require('../actions/addresses_server_actions.js.coffee')

module.exports =
  connect_faye_client: (channel) ->
    unless Faye?
      console.warn('No faye client present. Is faye running?')
    else
      source = new Faye.Client((if window.location.origin.indexOf('localhost') > 0 then "http://localhost:9292" else window.location.origin) + '/faye')
      source.subscribe '/posts/' + channel, (post) ->
        PostsServerActions.receivedPost post
      source.subscribe '/projects/' + channel, (project) ->
        ProjectsServerActions.receivedProject project
      source.subscribe '/messages/' + channel, (message) ->
        MessagesServerActions.receivedMessage message
  getZip: (zip) ->
    $.ajax
      url: Routes.zip_path()
      dataType: 'json'
      method: 'GET'
      data: {zip: zip}
    .done (data, textStatus, jqXHR) ->
      AddressesServerActions.receivedAddresses data
    .fail (data, textStatus, jqXHR) ->
      AddressesServerActions.receivedAddresses data
  getApartments: ->
    $.ajax
      url: Routes.apartments_path()
      dataType: 'json'
    .done (data, textStatus, jqXHR) ->
      ApartmentServerActions.receivedApartments data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      ApartmentServerActions.receivedApartments data, textStatus, jqXHR
  getBuildings: ->
    $.ajax
      url: Routes.buildings_path()
      dataType: 'json'
    .done (data, textStatus, jqXHR) ->
      BuildingsServerActions.receivedBuildings data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      BuildingsServerActions.receivedBuildings data, textStatus, jqXHR
  getBuilding: (id) ->
    $.ajax
      url: Routes.building_path(id)
      dataType: 'json'
    .done (data, textStatus, jqXHR) ->
      BuildingsServerActions.receivedBuilding data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      BuildingsServerActions.receivedBuilding data, textStatus, jqXHR

  getDirectory: (id) ->
    $.ajax
      url: Routes.directory_path(id)
      dataType: 'json'
      method: 'GET'
    .done (data, textStatus, jqXHR) ->
      BuildingsServerActions.receivedDirectory data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      BuildingsServerActions.receivedDirectory data, textStatus, jqXHR

  getBuildingFeed: (id) ->
    $.ajax
      url: Routes.building_feed_path(id)
      dataType: 'json'
      method: 'GET'
    .done (data, textStatus, jqXHR) ->
      BuildingsServerActions.receivedFeed data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      BuildingsServerActions.receivedFeed data, textStatus, jqXHR
  
  getInitialBuildingFeed: (id) ->
    console.log('test')
    $.ajax
      url: Routes.initial_building_feed_path(id)
      dataType: 'json'
      method: 'GET'
    .done (data, textStatus, jqXHR) ->
      BuildingsServerActions.receivedInitialFeed data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      BuildingsServerActions.receivedInitialFeed data, textStatus, jqXHR

  getReminders: ->
    $.ajax
      url: Routes.reminders_path()
      dataType: 'json'
    .done (data, textStatus, jqXHR) ->
      RemindersServerActions.receivedReminders data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      RemindersServerActions.receivedReminders data, textStatus, jqXHR

  getTasks: ->
    $.ajax
      url: Routes.tasks_path()
      dataType: 'json'
    .done (data, textStatus, jqXHR) ->
      TasksServerActions.receivedTasks data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      TasksServerActions.receivedTasks data, textStatus, jqXHR
  getPayments: ->
    $.ajax
      url: Routes.payments_path()
      dataType: 'json'
    .done (data, textStatus, jqXHR) ->
      PaymentsServerActions.receivedPayments data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      PaymentsServerActions.receivedPayments data, textStatus, jqXHR
  getPosts: ->
    $.ajax
      url: Routes.posts_path()
      dataType: 'json'
    .done (data, textStatus, jqXHR) ->
      PostsServerActions.receivedPosts data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      PostsServerActions.receivedPosts data, textStatus, jqXHR
  getProjects: ->
    $.ajax
      url: Routes.projects_path()
      dataType: 'json'
    .done (data, textStatus, jqXHR) ->
      ProjectsServerActions.receivedProjects data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      ProjectsServerActions.receivedProjects data, textStatus, jqXHR

  getConversations: ->
    $.ajax
      url: Routes.conversations_path()
      dataType: 'json'
    .done (data, textStatus, jqXHR) ->
      ConversationsServerActions.receivedConversations data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      ConversationsServerActions.receivedConversations data, textStatus, jqXHR
  getRequests: ->
    $.ajax
      url: Routs.requests_path()
      dataType: 'json'
    .done (data, textStatus, jqXHR) ->
      RequestsServerActions.receivedRequests data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      RequestsServerActions.receivedRequests data, textStatus, jqXHR
  postMessage: (data) ->
    $.ajax
      url: Routes.conversations_path()
      method: 'post'
      dataType: 'json'
      data: data
    .done (data, textStatus, jqXHR) ->
      ConversationsServerActions.receivedCreatedConversation data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      ConversationsServerActions.receivedCreatedConversation data, textStatus, jqXHR
  postContact: (data) ->
    $.ajax
      url: Routes.contacts_path()
      method: 'post'
      dataType: 'json'
      data: data
  startNewConversation: (email) ->
    $.ajax
      url: Routes.conversations_path()
      method: 'post'
      data: {email: email}
      dataType: 'json'
    .done (data, textStatus, jqXHR) ->
      ConversationsServerActions.receivedCreatedConversation data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      ConversationsServerActions.receivedCreatedConversation data, textStatus, jqXHR
  createCustomer: (dob) ->
   $.ajax
    url: Routes.customer_path()
    method: 'post'
    data: {dob: dob}
   .done (data, textStatus, jqXHR) ->
    PaymentsServerActions.receivedCustomer data, textStatus, jqXHR
   .fail (data, textStatus, jqXHR) ->
    PaymentsServerActions.receivedCustomer data, textStatus, jqXHR
  getMessages: ->
    $.ajax
      url: Routes.messages_path()
      dataType: 'json'
    .done (data, textStatus, jqXHR) ->
      MessagesServerActions.receivedMessages data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      MessagesServerActions.receivedMessages data, textStatus, jqXHR
  getPeople: ->
    $.ajax
      url: Routes.people_path()
      dataType: 'json'
    .done (data, textStatus, jqXHR) ->
      PeopleServerActions.receivedPeople data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      PeopleServerActions.receivedPeople data, textStatus, jqXHR
  createBuilding: (data) ->
    $.ajax
      url: Routes.buildings_path()
      dataType: 'json'
      method: "POST"
      data: data
    .done (data, textStatus, jqXHR) ->
      BuildingsServerActions.addedBuilding data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      BuildingsServerActions.addedBuilding data, textStatus, jqXHR
  createNewProperty: (property, apartments, tenants) ->
    $.ajax
      url: Routes.buildings_path()
      dataType: 'json'
      method: 'POST'
      data: {property: property, apartments: apartments, tenants: tenants }
    .done (data, textStatus, jqXHR) ->
      BuildingsServerActions.addedBuilding data, textStatus, jqXHR
  createConversation: (data) ->
    $.ajax
      url: Routes.conversations_path()
      dataType: 'json'
      method: 'POST'
      data: data
    .done (data, textStatus, jqXHR) ->
      ConversationsServerActions.receivedCreatedConversation data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      ConversationsServerActions.receivedCreatedConversation data, textStatus, jqXHR
  createReminder: (data) ->
    $.ajax
      url: Routes.reminders_path()
      dataType: 'json'
      method: 'POST'
      data: data
    .done (data, textStatus, jqXHR) ->
      RemindersServerActions.receivedReminder data
    .fail (data, textStatus, jqXHR) ->
      RemindersServerActions.receivedReminder data
  createRequest: (data) ->
    $.ajax
      url: Routes.requests_path()
      dataType: 'json'
      method: 'POST'
      data: data
    .done (data, textStatus, jqXHR) ->
      RequestsServerActions.receivedRequest data
    .fail (data, textStatus, jqXHR) ->
      RequestsServerActions.receivedRequest data
  addPeopleToConversation: (conversation_id, person_id) ->
    $.ajax
      url: Routes.conversation_path(conversation_id)
      dataType: 'json'
      method: 'PATCH'
      data: person_id
    .done (data, textStatus, jqXHR) ->
      ConversationsServerActions.addedToConversation data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      ConversationsServerActions.addedToConversation data, textStatus, jqXHR
  createPost: (data) ->
    $.ajax
      url: Routes.posts_path()
      dataType: 'json'
      method: 'POST'
      data: data
    .done (data, textStatus, jqXHR) ->
      PostsServerActions.createdNewPost data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      PostsServerActions.createdNewPost data, textStatus, jqXHR
  createProject: (data) ->
    $.ajax
      url: Routes.projects_path()
      dataType: 'json'
      method: 'POST'
      contentType: 'application/json'
      data: JSON.stringify data
    .done (data, textStatus, jqXHR) ->
      ProjectsServerActions.createdNewProject data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      ProjectsServerActions.createdNewProject data, textStatus, jqXHR

  createMessage: (text, target_type, target_id) ->
    $.ajax
      url: Routes.messages_path()
      dataType: 'json'
      method: 'POST'
      data: {text: text,target_type: target_type, target_id: target_id}
    .done (data, textStatus, jqXHR) ->
      MessagesServerActions.createdMessage data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      MessagesServerActions.createdMessage data, textStatus, jqXHR
  addPerson: (person_id) ->
    $.ajax
      url: Routes.apartment_people()
      dataType: 'json'
      method: 'POST'
    .done (data, textStatus, jqXHR) ->
      PeopleViewActions.addedPerson data, textStatus, jqXHR
    .fail (data, textStatus, jqXHR) ->
      PeopleViewActions.addedPerson data, textStatus, jqXHR
  postNewTask: (data) ->
    $.ajax
      url: Routes.tasks_path()
      dataType: 'json'
      method: 'POST'
      data: data
    .done (data, textStatus, jqXHR) ->
      TasksServerActions.receivedTask data
    .fail (data, textStatus, jqXHR) ->
      TasksServerActions.receivedTask data
  postNewMessage: (message, id) ->
    $.ajax
      url: Routes.conversation_path(id)
      dataType: 'json'
      method: 'PUT'
      data: { message: message }
    .done (data, textStatus, jqXHR) ->
      console.log data
    .fail (data, textStatus, jqXHR) ->
      console.log(data)
  postNewPayment: (data) ->
    $.ajax
      url: Routes.payments_path()
      dataType: 'json'
      method: 'POST'
      data: data
    .done (data, textStatus, jqXHR) ->
      PaymentsServerActions.receivedPayment data
    .fail (data, textStatus, jqXHR) ->
      PaymentsServerActions.receivedPayment data
  updatePayment: (data) ->
    $.ajax
      url: Routes.payment_path(data.payment.id)
      dataType: 'json'
      method: 'PUT'
      data: data
    .done (data, textStatus, jqXHR) ->
      PaymentsServerActions.updatedPayment data
    .fail (data, textStatus, jqXHR) ->
      console.log(data)
  updatePost: (id,data) ->
    $.ajax
      url: Routes.post_path(id)
      dataType: 'json'
      method: 'PUT'
      data: data
    .done (data, textStatus, jqXHR) ->
      PostsServerActions.updatedPost data,textStatus
    .fail (data, textStatus, jqXHR) ->
      PostsServerActions.updatedPost data, textStatus
  updateProject: (id,data) ->
    $.ajax
      url: Routes.project_path(id)
      dataType: 'json'
      method: 'PUT'
      contentType: 'application/json'
      data: JSON.stringify data
    .done (data, textStatus, jqXHR) ->
      ProjectsServerActions.updatedProject data,textStatus
    .fail (data, textStatus, jqXHR) ->
      ProjectsServerActions.updatedProject data, textStatus
  updateTask: (data) ->
    $.ajax
      url: Routes.task_path(data.id)
      dataType: 'json'
      method: 'PUT'
      data: JSON.stringify data
    .done (data, textStatus, jqXHR) ->
      TasksServerActions.updateTask data
    .fail (data, textStatus, jqXHR) ->
      console.log(data)
  changePostStatus: (id, options) ->
    $.ajax
      url: Routes.post_path(id)
      dataType: 'json'
      method: 'PATCH'
      data: {archive: options}
    .done (data, textStatus, jqXHR) ->
      PostsServerActions.changedStatus data
    .fail (data, textStatus, jqXHR) ->
      PostsServerActions.changedStatus data
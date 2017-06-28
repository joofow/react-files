BuildingSection = require('../buildings/buildings_section.js.coffee')
PostsHeaderSection = require('../posts/posts_header_section.js.coffee')
PostsDetailsSection = require('../posts/posts_details_section.js.coffee')
DirectorySection = require('../directories/directory_section.js.coffee')
BuildingViewActions = require('../../actions/buildings_view_actions.js.coffee')
SearchBox = require('../utilities/search_box.js.coffee')
BuildingSearchSection = require('../buildings/building_search_section.js.coffee')

PostsPage = React.createClass
	displayName: 'PostsPage'

	getInitialState: ->
		directory_visible: false
		filtered_buildings: @props.data.buildings
		filtered_posts: @props.data.posts
		archive: false

	componentWillReceiveProps: (nextProps) ->
		if @props.data.posts != nextProps.data.posts
				@setState
					filtered_posts: if @state.archive then nextProps.data.archive else nextProps.data.props

	_show_directory: ->
		@setState
			directory_visible: !@state.directory_visible

	_open_new_building: (id) ->
		BuildingViewActions.getDirectory id
		BuildingViewActions.getBuilding id

	_show_archive: ->
		@setState
			filtered_posts: if @state.archive then @props.data.posts else @props.data.archive
			archive: !@state.archive

	_search: (exp) ->
		re = new RegExp(exp,"g");
		temp_state = @props.data.buildings.filter (b) ->
			(b.address_line_1 && b.address_line_1.match re) || (b.address_line_2 && b.address_line_2.match re) || (b.city_name && b.city_name.match re) || (b.zipcode && b.zipcode.toString().match re)
		b_ids = temp_state.map (b) ->
			b.id
		temp_aps = @props.data.apartments.filter (a) ->
			b_ids.includes a.bid
		a_ids = temp_aps.map (a) ->
			a.id
		temp_posts = if @state.archive
			@props.data.archive.filter (p) ->
				(p.post_target_type == 'Apartment' && a_ids.includes p.post_target_id) || (p.post_target_type == 'Building' && b_ids.includes p.post_target_id)
		else
			@props.data.posts.filter (p) ->
				(p.post_target_type == 'Apartment' && temp_aps.includes p.post_target_id) || (p.post_target_type == 'Building' && b_ids.includes p.post_target_id)
		@setState
			filtered_buildings: temp_state
			filtered_posts: temp_posts

	_add_new_post: ->
		@props.show_new_post()

	_all_buidlings: ->
		console.log('this is nt')

	render: ->
		<div className={@props.visible}>
			<div className='row'>
				<div className='small-12 columns' data-cssid='posts-title-section'>
					<div className='row'>
						<div className='small-12 text-center'>
							Posts
							<span className='right tenant-dir-button' onClick={@_show_directory}>Tenant Directory</span>
						</div>
					</div>
				</div>
			</div>
			<div className='row'>
				<div className='medium-3 columns' data-cssid='building-left-section'>
					<div className='page-header row'>
						<SearchBox search={@_search} />
					</div>
					<BuildingSection buildings={ @state.filtered_buildings} change_building={@_open_new_building} />
				</div>
				<div className='medium-9 columns end'>
					<div className='row'>
						<div className='small-11 small-centered columns'>
								<PostsHeaderSection archive={@_show_archive} current={@state.archive} open_new_post={@_add_new_post}/>
						</div>
					</div>
					<div className='row ll-feed-section'>
						<div className={ if @state.directory_visible then 'medium-9 columns' else 'small-11 small-centered columns'} data-cssid='building-main-feed'>
							<PostsDetailsSection data={@state.filtered_posts} people={@props.people} buildings={@props.data.buildings} apartments={@props.data.apartments} archive={@state.archive}/>
						</div>
						<div className={if @state.directory_visible then 'small-3 columns' else 'hide'} data-cssid='directory-section'>
							<BuildingSearchSection />
							<DirectorySection directory={@props.data.directory} />
						</div>
					</div>
				</div>
			</div>
		</div>

module.exports = PostsPage
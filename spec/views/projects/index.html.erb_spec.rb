# frozen_string_literal: true

describe 'projects/index', type: :view do
  let!(:projects) { create_list(:project, 5) }

  before do
    assign :projects, projects
    render
  end

  it 'renders a title' do
    assert_select 'h1', text: 'Projects'
  end

  it 'renders a list of projects' do
    assert_select '.project', count: 5
  end

  it 'renders project information' do
    assert_select '.project' do
      assert_select 'p', text: Regexp.new(projects.first.name)
      assert_select 'p', text: Regexp.new(projects.first.description)
    end
  end

  it 'renders links to projects' do
    assert_select 'a[href=?]', project_path(projects.first)
  end

  it 'renders a new project link' do
    assert_select 'a[href=?]', new_project_path
  end
end

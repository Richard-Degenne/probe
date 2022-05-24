# frozen_string_literal: true

describe 'projects/show', type: :view do
  let!(:project) { create(:project) }

  before do
    assign :project, project
    render
  end

  it 'renders a title' do
    assert_select 'h1', text: 'Project'
  end

  it 'renders the name' do
    assert_select 'p', text: Regexp.new(project.name)
  end

  it 'renders the description' do
    assert_select 'p', text: Regexp.new(project.description)
  end

  it 'renders an edit link' do
    assert_select 'a[href=?]', edit_project_path(project)
  end

  it 'renders a delete button' do
    assert_select 'form[class=button_to][action=?]', project_path(project) do
      assert_select 'input[name=_method][value=delete]'
    end
  end

  it 'renders a "Back" link' do
    assert_select 'a[href=?]', projects_path, text: 'Back to projects'
  end
end

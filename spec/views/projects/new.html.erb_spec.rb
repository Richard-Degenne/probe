# frozen_string_literal: true

describe 'projects/new', type: :view do
  before do
    assign :project, build(:project)
    render
  end

  it 'renders the title' do
    assert_select 'h1', text: 'New project'
  end

  it 'renders the form' do
    assert_select 'form[action=?][method=?]', projects_path, 'post' do
      assert_select 'input[name=?]', 'project[name]'
      assert_select 'input[name=?]', 'project[description]'
    end
  end

  it 'renders a "Back" link' do
    assert_select 'a[href=?]', projects_path, text: 'Back to projects'
  end
end

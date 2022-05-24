# frozen_string_literal: true

require 'rails_helper'

describe 'projects/edit', type: :view do
  before do
    @project = assign(:project, Project.create!(
                                  name: 'MyString',
                                  description: 'MyString'
                                ))
  end

  it 'renders the edit project form' do
    render

    assert_select 'form[action=?][method=?]', project_path(@project), 'post' do
      assert_select 'input[name=?]', 'project[name]'

      assert_select 'input[name=?]', 'project[description]'
    end
  end
end

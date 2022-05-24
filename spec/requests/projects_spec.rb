# frozen_string_literal: true

describe '/projects', type: :request do
  describe 'GET /index' do
    subject(:index) do
      get projects_url, headers: headers
      response
    end

    before { create_list(:project, 5).first }

    include_examples 'HTML response'

    context 'with JSON' do
      include_context 'json'

      include_examples 'JSON response'
    end
  end

  describe 'GET /show' do
    subject(:show) do
      get project_url(project), headers: headers
      response
    end

    let!(:project) { create_list(:project, 5).first }

    include_examples 'HTML response'

    context 'with JSON' do
      include_context 'json'

      include_examples 'JSON response'

      it 'renders the project' do
        expect(JSON.parse(show.body)['id']).to eq project.id
      end
    end
  end

  describe 'GET /new' do
    subject(:new) do
      get new_project_url
      response
    end

    include_examples 'HTML response'
  end

  describe 'GET /edit' do
    subject(:edit) do
      get edit_project_url(project)
      response
    end

    let(:project) { create(:project) }

    include_examples 'HTML response'
  end

  describe 'POST /create' do
    subject(:kreate) do
      post projects_url, headers: headers, params: params
      response
    end

    let(:params) { { project: attributes_for(:project) } }

    include_examples 'HTML response', status: :found

    it 'creates a project' do
      expect { kreate }.to change(Project, :count).by(1)
    end

    it { is_expected.to redirect_to(project_url(Project.last)) }

    context 'with JSON' do
      include_context 'json'

      let(:params) { attributes_for(:project).to_json }

      include_examples 'JSON response', status: :created
    end

    context 'with invalid parameters' do
      let(:params) { { project: attributes_for(:project, :invalid) } }

      include_examples 'HTML response', status: :unprocessable_entity

      it 'does not create a new Project' do
        expect { kreate }.not_to change(Project, :count)
      end

      context 'with JSON' do
        include_context 'json'

        let(:params) { attributes_for(:project, :invalid).to_json }

        include_examples 'JSON response', status: :unprocessable_entity
      end
    end
  end

  describe 'PUT /update' do
    subject(:update) do
      put project_url(project), headers: headers, params: params
      project.reload
      response
    end

    let!(:project) { create(:project) }
    let(:params) { { project: attributes_for(:project) } }

    include_examples 'HTML response', status: :found
    it { is_expected.to redirect_to(project_url(project)) }

    it 'updates the project' do
      expect { update }.to change(project, :attributes)
    end

    context 'with JSON' do
      include_context 'json'

      let(:params) { attributes_for(:project).to_json }

      include_examples 'JSON response'
    end

    context 'with invalid parameters' do
      let(:params) { { project: attributes_for(:project, :invalid) } }

      include_examples 'HTML response', status: :unprocessable_entity

      it 'does not update the project' do
        expect { update }.not_to change(project, :attributes)
      end

      context 'with JSON' do
        include_context 'json'

        let(:params) { attributes_for(:project, :invalid).to_json }

        include_examples 'JSON response', status: :unprocessable_entity
      end
    end
  end

  describe 'DELETE /destroy' do
    subject(:destroy) do
      delete project_url(project), headers: headers
      response
    end

    let!(:project) { create(:project) }

    include_examples 'HTML response', status: :found
    it { is_expected.to redirect_to projects_url }

    it 'destroys the project' do
      expect { destroy }.to change(Project, :count).by(-1)
    end

    context 'with JSON' do
      include_context 'json'

      it { is_expected.to have_http_status :no_content }
    end
  end
end

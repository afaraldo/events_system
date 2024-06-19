module Api
  module V1
    class EventsController < ApiController
      before_action :authenticate_user!
      before_action :set_event, only: %i[show update destroy]
      after_action :verify_authorized, except: :index
      protect_from_forgery with: :null_session

      def index
        @search = policy_scope(Event).ransack(params[:q])
        @events = @search.result.includes(:event_registrations).page(params[:page])
        render json: {
          events: @events,
          meta: {
            current_page: @events.current_page,
            next_page: @events.next_page,
            prev_page: @events.prev_page,
            total_pages: @events.total_pages,
            total_count: @events.total_count
          }
        }
      end

      def show
        authorize @event
        render json: @event
      end

      def create
        @event = Event.new(event_params)
        authorize @event
        @event.user = current_user
        if @event.save
          render json: @event, status: :created
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      def update
        authorize @event
        if @event.update(event_params)
          render json: @event
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @event
        @event.destroy
        head :no_content
      end

      private

      def set_event
        @event = Event.find(params[:id])
      end

      def event_params
        params.require(:event).permit(:description, :end_time, :name, :organizer, :start_time, :status)
      end
    end
  end
end

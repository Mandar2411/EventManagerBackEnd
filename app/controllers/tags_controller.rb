class TagsController < ApplicationController
    before_action :set_tag, only: %i[ show edit update destroy ]
  
    # GET /tags or /tags.json
    def index
      @tags = Tag.all
    end
  
    # GET /tags/1 or /tags/1.json
    def show
      @tags = Tag.all
    end
    
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_tag
        @tag = Tag.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def tag_params
        params.require(:tag).permit(:name)
      end
  end
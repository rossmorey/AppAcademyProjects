class Api::BenchesController < ApplicationController
  def index
    @benches = Bench.all
  end

  def create
  end
end

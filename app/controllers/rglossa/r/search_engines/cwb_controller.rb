require 'rserve'

module Rglossa
  module R
    module SearchEngines
      class CwbController < ApplicationController

        def query_freq
          query = params[:query]
          corpus = params[:corpus].upcase

          conn = Rserve::Connection.new
          conn.eval('library("rcqp")')
          corp = conn.eval(%Q{corp <- corpus("#{corpus}")})
          subcorp = conn.eval(%Q{subcorp <- subcorpus(corp, '#{query}')})

          freqs = conn.eval('freqs <- cqp_flist(subcorp, "match", "word")')

          pairs = []
          freqs.attr.to_ruby[0].zip(freqs.to_ruby) do |a, f|
            pairs << {form: a, freq: f}
          end

          render json: {pairs: pairs, success: true}
        end

      end
    end
  end
end

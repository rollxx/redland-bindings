require 'rdf/redland/stream'

# require RDF::Redland;

# query = RDF::Redland::RDQL.new('query_string')
# results = model.execute($query)
# results.each do |row|
#    row.values.each do |row,value|
puts "#{row} => #{value"
#    end
# end

module Redland

  class RDQL

    def initialize(query,language=nil,uri=nil)
      @query = query
      @language = language
      @uri = uri
      @query = Redland.librdf_new_query($world.world,language,uri,query)
      return nil if not @query
      ObjectSpace.define_finalizer(self,RDQL.create_finalizer(@query))
    end

    def execute(model)
      return RDF::Redland::librdf_query_run_as_bindings(@query,model.model)
    end

    def RDQL.create_finalizer(query)
      proc{|id| "Finalizer on #{id}"
        puts "closing rdql"
        Redland::librdf_free_query(query)
      }
    end
    

  end

  class QueryResult

    def initialize()
    end

    def bindings
      results = []
      (0...self.size).each{|i| result |i| }
    end

    def binding_name(index)
      return Redland.librdf_query_results_get_binding_name(@query_results,index)
    end

    def binding_value(index)
      node = Redland.librdf_query_results_get_binding_value(@query_results,index)
      return Redland::Node.new_from_object(node)
    end

    def size()
      return Redland.librdf_query_results_get_bindings_count(@query_results)
    end
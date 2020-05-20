module ActiveModel::Associations
  module AssociationScopeExtension
    # This gem currently still supports Rails 6 as-is because there is no definition change
    # to add_constraints from 5.2.3 to 6.0.0. Refer to
    # https://apidock.com/rails/v5.2.3/ActiveRecord/Associations/AssociationScope/add_constraints
    if ActiveRecord.version >= Gem::Version.new("5.2.0")
      def add_constraints(scope, owner, chain)
        chain_head = chain.first
        refl = chain_head.instance_variable_get(:@reflection)
        if refl.options[:active_model]
          target_ids = refl.options[:target_ids]
          return scope.where(id: owner[target_ids])
        end

        super
      end
    elsif ActiveRecord.version >= Gem::Version.new("5.1.0")
      def add_constraints(scope, owner, refl, chain_head, chain_tail)
        if refl.options[:active_model]
          target_ids = refl.options[:target_ids]
          return scope.where(id: owner[target_ids])
        end

        super
      end
    elsif ActiveRecord.version >= Gem::Version.new("5.0.0")
      def add_constraints(scope, owner, association_klass, refl, chain_head, chain_tail)
        if refl.options[:active_model]
          target_ids = refl.options[:target_ids]
          return scope.where(id: owner[target_ids])
        end

        super
      end
    else
      def add_constraints(scope, owner, assoc_klass, refl, tracker)
        if refl.options[:active_model]
          target_ids = refl.options[:target_ids]
          return scope.where(id: owner[target_ids])
        end

        super
      end
    end
  end
end

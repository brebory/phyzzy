#Entities
#========
#
#Generic base classes for the Phyzzy physics engine. Provides a starting point for other modules to build from.
#
## Prelude #
#Require the components needed for entity. Functional helpers from `helpers.litcoffee`, Error classes from `errors.litcoffee`.

    { zip, box } require './helpers'
    { DimensionError } = require './errors'
    
#Classes
#=======
#
#This section describes the base classes that the entity system provides for clients and other library modules. 
#They provide a starting point for all major types of physics entities, from simple particles in space to complicated 3D meshes.
#
## Entity #
#Class `Entity` describes a basic physics entity with position, velocity, and direction. This is the basic unit that all physics classes build from.

#### Constructor ###
#* @param `position` - Position vector as an `Array` of `Numbers`.
#* @param `speed` - Speed in meters-per-second as a `Number`.
#* @param `direction` - `Array` of angles that describe the orientation of the object.
#* @param `in_radians` - Optional `Boolean` parameter that controls if input is in radians already. Defaults to false, so the constructor assumes that all angles are in degrees.
  
    class Entity
      constructor: (@position, @speed, @direction, @in_radians = False) ->

#Box the `direction` argument in an `Array` if we recieved a singleton `Number` as the argument. 
#The rest of the constructor assumes that `direction` is an `Array`.
#
        @direction = box(@direction) if not @direction.length
        throw new DimensionError(
               """
               Position and direction do not match arity for dimension: #{@position.length}
               """
        )
        @direction = @direction.map((angle) -> angle * Math.PI / 180) if not @in_radians
        @velocity = @position.map (angle, index, array) ->
            @direction[..(array.length - index)].reduce (accumulated, next, nested_index) ->
              switch index
                when 1 then accumulated * (if nested_index == 0 then Math.sin next else Math.cos next)
                else accumulated * Math.cos next
            , @speed

      update: (dt) ->
        @position = zip @position, @velocity, (pos, vel) -> pos + vel * dt


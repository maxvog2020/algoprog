import MaterialList from "./MaterialList"

class Level extends MaterialList
    constructor: (id, title, levels) ->
        if not levels
            levels = title
            title = "Уровень #{id}"
        super(levels)
        @title = title
        @id = id

    build: (context) ->
        properties = 
            _id: @id
            type: "level"
            title: @title

        material = await super.build(context, properties, {keepSubmaterials: true})

        return material

export default level = (args...) -> () -> new Level(args...)
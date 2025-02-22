"""
    Layer

Defines a new layer within the video.

# Fields
- `frames::Frames`: A range of frames for which the `Layer` exists
- `width::Int`: Width of the layer
- `height::Int`: hegiht of the layer
- `position::Point`: initial positon of the center of the layer on the main canvas
- `layer_objects::Vector{AbstractObject}`: Objects defined under the layer
- `actions::Vector{AbstractAction}`: a list of actions applied to the entire layer 
- `current_setting::LayerSetting`: The current state of the layer see [`LayerSetting`](@ref)
- `opts::Dict{Symbol,Any}`: can hold any options defined by the user
- `image_matrix::Vector`: Hold the Drwaing of the layer as a Luxor image matrix
"""
mutable struct Layer <: AbstractObject
    frames::Frames
    width::Int
    height::Int
    position::Point
    layer_objects::Vector{AbstractObject}
    actions::Vector{AbstractAction}
    current_setting::LayerSetting
    opts::Dict{Symbol,Any}
    image_matrix::Union{Array,Nothing}
    layer_cache::LayerCache
end

"""
    CURRENT_LAYER

holds the current layer in an array to be declared as a constant
The current layer can be accessed using CURRENT_LAYER[1]
"""
const CURRENT_LAYER = Array{Layer,1}()

function Layer(
    frames,
    width,
    height,
    position::Point;
    layer_objects::Vector{AbstractObject} = AbstractObject[],
    actions::Vector{AbstractAction} = AbstractAction[],
    setting::LayerSetting = LayerSetting(),
    misc::Dict{Symbol,Any} = Dict{Symbol,Any}(),
    mat = nothing,
    layer_cache::LayerCache = LayerCache(),
)
    Layer(
        CURRENT_VIDEO[1],
        frames,
        width,
        height,
        position;
        layer_objects,
        actions,
        setting,
        misc,
        mat,
        layer_cache,
    )
end

# for width, height and position defaults are defined in the to_layer_m function
function Layer(
    video::Video,
    frames,
    width,
    height,
    position::Point;
    layer_objects::Vector{AbstractObject} = AbstractObject[],
    actions::Vector{AbstractAction} = AbstractAction[],
    setting::LayerSetting = LayerSetting(),
    misc::Dict{Symbol,Any} = Dict{Symbol,Any}(),
    mat = nothing,
    layer_cache::LayerCache = LayerCache(),
)
    if width === nothing
        width = video.width
    end
    if height === nothing
        height = video.height
    end

    layer = Layer(
        frames,
        width,
        height,
        position,
        layer_objects,
        actions,
        setting,
        misc,
        mat,
        layer_cache,
    )

    set_constant!(CURRENT_LAYER, layer)
    push!(video.layers, layer)

    return layer
end

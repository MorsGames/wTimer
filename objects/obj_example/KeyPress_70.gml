/// @desc Deactivate the object

// Create an object that will reactivate this one
instance_create_layer(0, 0, layer, obj_reactivator)

// Deactivate this instance
instance_deactivate_object(id);
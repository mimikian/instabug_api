object @bug
attributes :number, :priority, :comment
attribute :status_mapped_value => :status
child (@state) {
  attributes :os, :device, :memory, :storage
}
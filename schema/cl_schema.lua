
local Schema = Schema

function Schema:ChatNotify(message)
	ix.chat.Send(nil, "notice", message)
end
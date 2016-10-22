# Bugs 
Bug.create(application_token: 'b78f8f2319c2b95d79954', number: '1', status: 'closed', priority: 'minor', comment: 'this is a comment' )
Bug.create(application_token: 'b78f8f2319c2b95d79954', number: '1', status: 'In-progress', priority: 'major', comment: 'this is a comment' )

Bug.create(application_token: 'aaaaaaaaaaaaaaaaaaaa', number: '1', status: 'closed', priority: 'minor', comment: 'this is a comment' )
Bug.create(application_token: 'aaaaaaaaaaaaaaaaaaaa', number: '1', status: 'In-progress', priority: 'major', comment: 'this is a comment' )

# State
State.create(bug_id: 1, device: 'device type 1', os: 'mac', memory: 1024, storage: 10)
State.create(bug_id: 2, device: 'device type 2', os: 'mac', memory: 1024, storage: 10)
State.create(bug_id: 3, device: 'device type 3', os: 'mac', memory: 1024, storage: 10)
State.create(bug_id: 4, device: 'device type 4', os: 'mac', memory: 1024, storage: 10)



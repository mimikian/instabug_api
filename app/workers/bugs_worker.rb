class BugsWorker
  include Sneakers::Worker
  from_queue "bugs", env: nil

  def work(raw_bug)
    Bug.create(JSON.parse(raw_bug))
    ack!
  end
end

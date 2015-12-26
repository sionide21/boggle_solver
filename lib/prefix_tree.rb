class PrefixTree
  def initialize
    @nodes = {}
    @entry = false
  end

  def <<(entry)
    head, *tail = *entry
    if head
      fetch(head) << tail
    else
      @entry = true
    end
  end

  def include?(entry)
    head, *tail = *entry
    return @entry unless head
    lookup(head).include?(tail)
  end

  def has_prefix?(entry)
    head, *tail = *entry
    return true unless head
    lookup(head).has_prefix?(tail)
  end

  private

  def fetch(val)
    @nodes[val] ||= PrefixTree.new
  end

  def lookup(val)
    @nodes[val] || EmptyPrefixTree.new
  end

  class EmptyPrefixTree
    def include?(*)
      false
    end

    def has_prefix?(*)
      false
    end
  end
end

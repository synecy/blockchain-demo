require 'pry'
require 'digest'

Block = Struct.new(:timestamp, :data, :prev_block_hash, :hash)

def setHash(block)
  headers = "#{block[:prev_block_hash]}#{block[:data]}#{block[:timestamp].to_s}"
  hash = Digest::SHA256.hexdigest(headers)
  block[:hash] = hash
  block
end

def newBlock(data, prev_block_hash)
  block = Block.new((Time.now.to_f * 1000).to_i, data, prev_block_hash, nil)
  block = setHash(block)
  block
end

def addBlock(blockchain, data)
  prev_block = blockchain[blockchain.length-1]
  new_block = newBlock(data, prev_block.hash)
  blockchain << new_block
end

def newGenesisBlock
  newBlock("Genesis block", "")
end

def newBlockchain
  genesis_block = newGenesisBlock()
  blockchain = Array.new
  blockchain << genesis_block
end


def main
  puts "Starting new blockchain..\n\n"
  blockchain = newBlockchain()
  blockchain = addBlock(blockchain, "TX: 1 coin(s) from a to b")
  blockchain = addBlock(blockchain, "TX: 4 coin(s) from a to b")
  blockchain = addBlock(blockchain, "TX: 2 coin(s) from b to a")

  blockchain.each do |block|
    puts "Previous block: #{block[:prev_block_hash]}"
    puts "Data: #{block[:data]}"
    puts "Hash: #{block[:hash]}\n\n"
  end
end
main

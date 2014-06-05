require_relative 'spec_helper'
 
def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end
 
songs = [
  "Phoenix - 1901",
  "Tokyo Police Club - Wait Up",
  "Sufjan Stevens - Too Much",
  "The Naked and the Famous - Young Blood",
  "(Far From) Home - Tiga",
  "The Cults - Abducted",
  "Phoenix - Consolation Prizes",
  "Harry Chapman - Cats in the Cradle",
  "Amos Lee - Keep It Loose, Keep It Tight"
]
 
describe "CLI Jukebox" do
 
  context "with commands" do
    it "responds to 'help'" do
      output = capture_stdout {help}
      expect(output).to match(/^(?=.*help)(?=.*list)(?=.*play)(?=.*exit).+/m)
    end
 
    it "responds to 'list'" do
      output = capture_stdout { list(songs) }
      expect(output).to match(/Phoenix - 1901/)
    end
 
    # stub! is deprecated but the test doesnt work with
    # stub
    it "responds to 'play' and accepts a number as an argument" do
      allow(self).to receive(:gets).and_return("1")
      # stub!(:gets).and_return("1")
      output = capture_stdout { play(songs) }
      expect(output).to match(/Phoenix - 1901/)
    end

    it "responds to 'play' and accepts a full song name as an argument" do
      allow(self).to receive(:gets).and_return("Phoenix - 1901")
      # stub!(:gets).and_return("Phoenix - 1901")
      output = capture_stdout { play(songs) }
      expect(output).to match(/Phoenix - 1901/)
    end

    it "responds to 'exit'" do
      output = capture_stdout { exit_jukebox }
      expect(output).to match(/Goodbye/)
    end
  end
 
  it "should start the script with the run method" do
    allow(self).to receive(:gets).and_return("exit")
    # stub!(:gets).and_return("exit")
    output = capture_stdout { run(songs) }
    output.should match(/Please enter a command:/)
  end

end
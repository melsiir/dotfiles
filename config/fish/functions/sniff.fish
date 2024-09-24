function sniff
    bash -c "grep -d '$argv' -t '^(GET|POST) ' 'tcp and port 80'"
end


# set a (printf %s (dbn ruby | string replace -r "Replaces:\s(<(.*?)>)" "" \
  #       | string replace -r "Breaks:\s(<(.*?)>)" "" \
  #       | string replace -r "Conflicts:\s(<(.*?)>)" ""\
  #       | string replace -r "Recommends:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
  #       |string replace -r "Suggests:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
  #       | string replace -r "\((.*?)\)" "" \
  #       | string replace -r "Reverse Depends:" "" \
  #       | string replace -r "Depends:" "" \
  #       | string replace -r ":a;N;!ba;s/\n/" "" \
  #       |  string replace -r "Conflicts:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
  #       |  string replace -r "Replaces:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
  #       |  string replace -r "Breaks:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
  #       | string replace -r "," " " \
  #       | string replace -r "\s+" " "))

# set k (printf %s (dbn ruby | sed  "/Recommends/d" \
  #  |  sed  "/Suggests/d" \
  #  |  sed  "/Replaces/d" \
  #  |  sed  "/Breaks/d" \
  #  |  sed  "/Reverse/d" \
  #  |  sed  "/Conflicts/d" \
  #  |  sed  "s/Depends://" \
  #  |  sed  "1d" \
  #  |  sed  -E "s/\((.*?)\)//g" \
  #  |  sed  's/^[[:blank:]]*//g' \
  #  |  sed  ':a;N;$!ba;s/\n/,/g' \
  #  |  sed  's/ //g'))




function tt -d "remove packages and all thair dependencies"
  set toremove ""
  # list all installed pkgs
  set rawlist  (pkg list-installed | string replace -r "\/(.*?)\]" ',' | string replace "Listing..." "")
  set list
  for i in (string split "," $rawlist)
    set iszero (string length $i)
    if ! test (string length $i) -eq 0
      set list "$list,$i"
    end
  end
  #add comma to the end and the start of list
  # set list ",$list"
  set list "$list,"



  for argument in $argv
    #list pkg dependencies
    set rawdependencies (dbn $argument | string replace -r "Replaces:\s(<(.*?)>)" "" $dependencies \
      | string replace -r "Breaks:\s(<(.*?)>)" "" \
      | string replace -r "Conflicts:\s(<(.*?)>)" ""\
      | string replace -r "Recommends:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
      |string replace -r "Suggests:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
      | string replace -r "\((.*?)\)" "" \
      | string replace -r "Reverse Depends:" "" \
      | string replace -r "Depends:" "" \
      | string replace -r ":a;N;!ba;s/\n/" "" \
      |  string replace -r "Conflicts:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
      |  string replace -r "Replaces:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
      |  string replace -r "Breaks:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
      | string replace -r "," " " \
      | string replace -r "\s+" ",")


    set dependencies
    for i in (string split "," $rawdependencies)
      if ! test (string length $i) -eq 0
        set dependencies "$dependencies,$i"
      end
    end

    set dependencies (string replace -r ",$argument," "" $dependencies)
    echo $dependencies

    #check if dependencies has other programs need's it
    for dependency in (string split "," $dependencies)
      #============================ 
      #remove dependencies
      set rawrdps (rdbn $dependency | string replace -r "Replaces:\s(<(.*?)>)" ""\
        | string replace -r "Breaks:\s(<(.*?)>)" "" \
        | string replace -r "Conflicts:\s(<(.*?)>)" ""\
        | string replace -r "Recommends:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
        |string replace -r "Suggests:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
        | string replace "$argument" "" \
        | string replace -r "\((.*?)\)" "" \
        | string replace -r "Reverse Depends:" "" \
        | string replace -r "Depends:" "" \
        | string replace -r ":a;N;!ba;s/\n/" "" \
        |  string replace -r "Conflicts:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
        |  string replace -r "Replaces:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
        |  string replace -r "Breaks:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
        | string replace -r "\s" "," \
        | string replace -r "\s+" "")
      set rdps
      for i in (string split "," $rawrdps)
        if ! test (string length $i) -eq 0
          set rdps "$rdps,$i"
        end
      end
      set rdps  (string replace -r ",$dependency," "" $rdps)
      #if reverse dependency contain one of dependencies of package that you want remove  then remove that string 
      set list (string replace ",$dependency," "," $list)      
      set canBeRemoved true
      for reverseDependency in (string split "," $rdps)
        if string match -q "*,$reverseDependency,*" $list
          set canBeRemoved false
          break
        end
      end
      if string match -q "*$dependency*" $toremove
        set notExisting false
      else
        set notExisting true
      end
      if $canBeRemoved; and $notExisting
        set toremove $toremove $dependency
      end

      #remove sub dependencies
      set rawsubDebs (dbn $dependency | string replace -r "Replaces:\s(<(.*?)>)" "" \
        | string replace -r "Breaks:\s(<(.*?)>)" "" \
        | string replace -r "Conflicts:\s(<(.*?)>)" ""\
        | string replace -r "Recommends:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
        |string replace -r "Suggests:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
        | string replace -r "\((.*?)\)" "" \
        | string replace -r "Reverse Depends:" "" \
        | string replace -r "Depends:" "" \
        | string replace -r ":a;N;!ba;s/\n/" "" \
        |  string replace -r "Conflicts:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
        |  string replace -r "Replaces:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
        |  string replace -r "Breaks:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
        | string replace -r "\s" "," \
        | string replace -r "\s+" "")


      set subDebs

      for i in (string split "," $rawsubDebs)
        if ! test (string length $i) -eq 0
          set subDebs "$subDebs,$i"
        end
      end
      echo $dependency
      echo $subDebs

      for subdeb in (string split "," $subDebs)
        set rawrsubdps (rdbn $subdeb | string replace -r "Replaces:\s(<(.*?)>)" "" \
          | string replace -r "Breaks:\s(<(.*?)>)" "" \
          | string replace -r "Conflicts:\s(<(.*?)>)" ""\
          | string replace -r "Recommends:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
          |string replace -r "Suggests:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
          |string replace -r "$subdeb" "" \
          | string replace -r "\((.*?)\)" "" \
          | string replace -r "Reverse Depends:" "" \
          | string replace -r "Depends:" "" \
          | string replace -r ":a;N;!ba;s/\n/" "" \
          |  string replace -r "Conflicts:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
          |  string replace -r "Replaces:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
          |  string replace -r "Breaks:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
          | string replace -r "\s" "," \
          | string replace -r "\s+" "")
        # sed -i "s/$subdeb//" rsubdpns.txt
        #if reverse dependency contain one of dependencies of package that you want remove  then remove that string
        set rsubdps
        for i in (string split "," $rawrsubdps)
          set iszero (string length $i)
          if test $iszero -eq 0
            set rsubdps "$subDebs,$i"
          end
        end

        # sed -i "s/$subdeb//" rsubdpns.txt
        #if reverse dependency contain one of dependencies of package that you want remove  then remove that string
        set list (string replace ",$subdeb," "," $list)      
        # trimdpn rsubdpns.txt
        set subCanBeRemoved true
        # set rsubdps (cat rsubdpns.txt)
        # echo $rsubdps
        for reverseSubDependency in (string split "," $rsubdps)
          if string match -q "*,$reverseSubDependency,*" $list
            # echo $reverseDependency
            set subCanBeRemoved false
            break
          end
        end

        #make sure there no duplucates pkgs
        if string match -q "*$subdeb*" $toremove
          set notExisting false
        else
          set notExisting true
        end
        if $subCanBeRemoved; and  $notExisting
          set toremove "$toremove $subdeb"
        end
      end


      #=====
    end

    set toremove $toremove $argument
  end
  echo $toremove
end

function trimdbnstring
  #first argument dbn or rdbn
  #second is package name
  printf %s ($argv[1] $argv[2]| sed  "/Recommends/d" \
    |  sed  "/Suggests/d" \
    |  sed  "/Replaces/d" \
    |  sed  "/Breaks/d" \
    |  sed  "/Reverse/d" \
    |  sed  "/Conflicts/d" \
    |  sed  "s/Depends://" \
    |  sed  "1d" \
    |  sed  -E "s/\((.*?)\)//g" \
    |  sed  's/^[[:blank:]]*//g' \
    |  sed  ':a;N;$!ba;s/\n/,/g' \
    |  sed  's/ //g')
end


function trimdbnstring1
  set raw (string replace -r "Replaces:\s(<(.*?)>)" "" $argv\
    | string replace -r "Breaks:\s(<(.*?)>)" "" \
    | string replace -r "Conflicts:\s(<(.*?)>)" ""\
    | string replace -r "Recommends:\s*\w*(-\w*(-\w*(-\w*)?)?)?" "" \
    |string replace -r "Suggests:\s*\w*(-\w*)?" "" \
    | string replace -r "\((.*?)\)" "" \
    | string replace -r "Depends:" "" \
    |  string replace -r "Conflicts:\s*\w*(-\w*)?" "" \
    |  string replace -r "Replaces:\s*\w*(-\w*)?" "" \
    |  string replace -r "Breaks:\s*\w*(-\w*)?" "" \
    | string replace -r "\s" "," \
    | string replace -r "\s+" "")

  set -l results
  for i in (string split "," $raw)
    if ! test (string length $i) -eq 0
      set results "$results,$i"
    end
  end
  echo  $results
end

function rr -d "remove packages and all thair dependencies"
  set toremove ""
  # list all installed pkgs
  set list (printf %s (pkg list-installed | sed "s/\/.*//g" | sed "/Listing.../d" | sed ':a;N;$!ba;s/\n/,/g'))
  #add comma to the end and the start of lsed -i "/Lsed -i "/Listing.../d"isting.../d"ist
  set list ",$list"
  set list "$list,"



  for argument in $argv
    #list pkg dependencies
    set dependencies (trimdbnstring dbn $argument)
    #check if dependencies has other programs need's it
    for dependency in (string split "," $dependencies)
      #============================ 
      #remove dependencies
      set rdps (trimdbnstring rdbn $dependency)
      set rdps (printf %s $rdps | sed "s/$argument//" | sed "s/,,/,/g")

      #if reverse dependency contain one of dependencies of package that you want remove  then remove that string 
      set list (string replace ",$dependency," "," $list)
      # echo $dependency
      # echo $rdps
      set canBeRemoved true
      for reverseDependency in (string split "," $rdps)
        if string match -q "*,$reverseDependency,*" $list
          set canBeRemoved false
          break
        end
      end
      if string match -q "*$dependency*" $toremove
        set notExisting false
      else
        set notExisting true
      end
      if $canBeRemoved; and $notExisting
        set toremove $toremove $dependency
      end

      #remove sub dependencies
      set subDebs (trimdbnstring dbn $dependency)
      # echo $subDebs
      for subdeb in (string split "," $subDebs)
        set rsubdps (trimdbnstring rdbn $subdeb)
        # sed -i "s/$subdeb//" rsubdpns.txt
        #if reverse dependency contain one of dependencies of package that you want remove  then remove that string
        set list (string replace ",$subdeb," "," $list)      
        set subCanBeRemoved true
        # echo $rsubdps
        for reverseSubDependency in (string split "," $rsubdps)
          if string match -q "*,$reverseSubDependency,*" $list
            # echo $reverseDependency
            set subCanBeRemoved false
            break
          end
        end

        #make sure there no duplucates pkgs
        if string match -q "*$subdeb*" $toremove
          set notExisting false
        else
          set notExisting true
        end
        if $subCanBeRemoved; and  $notExisting
          set toremove "$toremove $subdeb"
        end
      end
      #=======================
    end
    set toremove $toremove $argument
  end
  echo $toremove
end


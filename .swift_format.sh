find . | grep -v -e ^\./Pods/ | grep -e \.swift$ | xargs swift-format -i

pipeline {
  agent any
  stages {
    stage('Cancel previous build') {
      steps {
        milestone label: '', ordinal:  Integer.parseInt(env.BUILD_ID) - 1
        milestone label: '', ordinal:  Integer.parseInt(env.BUILD_ID)
      }
    }
    stage('Cocoapods') {
      steps {
        sh 'pod install'
      }
    }
    stage('Run Tests') {
      steps {
        sh 'xcodebuild build-for-testing -workspace EmeraldIOS.xcworkspace -scheme EmeraldIOS -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO | xcpretty'
        sh 'xctool run-tests -workspace EmeraldIOS.xcworkspace -scheme EmeraldIOS -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO'
      }
    }
    stage('Code cov') {
      steps {
        sh 'curl -s https://codecov.io/bash | bash -s - -v -t abb81841-17c8-4be4-a825-2e47dcbe2766'
      }
    }
  }
}